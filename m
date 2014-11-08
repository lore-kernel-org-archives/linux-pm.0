From: Rainer Fiebig <linx@jrfiebig.de>
Subject: [Patch] s2disk / hibernate: Bug 47931 / Bug 83821
Date: Sat, 08 Nov 2014 23:30:02 +0100
Message-ID: <2050847.UldR8WcHpO@linux-tez8.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:35809 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbaKHWfP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 8 Nov 2014 17:35:15 -0500
Received: from [84.143.188.194] (helo=linux-tez8.site)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.84)
	(envelope-from <linx@jrfiebig.de>)
	id 1XnEWH-0000C3-Cp
	for linux-pm@vger.kernel.org; Sat, 08 Nov 2014 23:30:09 +0100
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org


Hi!

I think I=E2=80=99ve found a solution for Bug 47931 and Bug 83821.
It makes s2disk almost 100% reliable on my x86_64-system.
Only one line of code needs to be modified and placed higher up in the =
code.


Background
s2disk sometimes does not succeed at the first attempt but needs two or=
 even=20
more attempts (Bug 47931, https://bugzilla.kernel.org/show_bug.cgi?id=3D=
47931).
This happens if more than 50% of memory is used by applications and=20
buffers/cache.=20
As buffers/cache can take up a lot of memory quickly, Bug 47931 may occ=
ur even=20
if only a few applications are running.

Bug 83821 (https://bugzilla.kernel.org/show_bug.cgi?id=3D83821.) causes=
 a=20
similar behavior if s2disk is executed immediately after a memory-inten=
sive=20
application was closed or if it is executed more than 2 times in a row =
after a=20
fresh system start.
That means it can occur even if less than 50% of memory is used.

=46or the user this is quite bewildering and time-consuming. It makes s=
2disk=20
unreliable and basically unusable.

I found out that both bugs can be prevented by issuing "drop_caches=3D1=
"=20
before s2disk.

In function "int hibernate_preallocate_memory(void)" in=20
kernel/power/snapshot.c "shrink_all_memory()" is called to free memory.
Unfortunately, it is placed too far down in the code to take effect.=20
This is why we run into Bug 47931.
If memory-usage is low, it may not be called at all. This probably caus=
es=20
Bug 83821.


Solution
The solution is simple: free memory early and do it with every s2disk.

Only one line of code needs to be modified and and put before
"saveable =3D count_data_pages();":

shrink_all_memory(count_data_pages() / 2);.

=46reeing 50% of used data-pages seems sufficient without applying too =
much=20
pressure which could have a negative effect on resumes and initial syst=
em-
responsiveness.=20

The "shrink_all_memory(saveable - size);"-statement further down in the=
 code=20
must be deleted.


Results
This modification has made s2disk almost 100% reliable on my system.

Testing was done with kernels 3.16.2 and 3.14.22 on an x86_64-system wi=
th=20
12 GB RAM.
I have not tested it on a 32-bit-system.

Here's an example of a case where s2disk now works=20
but surely would have failed before:


> free
             total       used       free     shared    buffers     cach=
ed
Mem:      11973244   11734724     238520          0    6107076    19957=
00
-/+ buffers/cache:    3631948    8341296
Swap:     10714108          0   10714108


I have found only two conditions where s2disk still fails:

1.) If "used - buffers/cache" is > 50% of memory.=20
In this case s2disk stops and returns to the desktop.=20
That's not a big problem and is to be expected due to its current limit=
=20
of 50% of RAM.
Example:


> free
             total       used       free     shared    buffers     cach=
ed
Mem:      11973244   10786352    1186892          0    1436860    23411=
56
-/+ buffers/cache:    7008336    4964908
Swap:     10714108    1003124    9710984

2.) If "used - buffers/cache" is very close to 50% of memory.
Here one may run into Bug 75101=20
(https://bugzilla.kernel.org/show_bug.cgi?id=3D75101). Which is bad, be=
cause it=20
requires a hard-reset.
I have encountered this only once when testing the limits.
But it may be a problem on systems with sparse memory.
Example:


> free
             total       used       free     shared    buffers     cach=
ed
Mem:      11997572    6490540    5507032          0      32600     5776=
32
-/+ buffers/cache:    5880308    6117264
Swap:     10714108     739580    9974528


Other than 2.) I have not encountered any major negative side-effects.
I use s2both and if memory usage was high before s2disk, resumes may ta=
ke a=20
little longer than after a plain suspend to RAM.
In those cases the system also may be a little less responsive initiall=
y.
=46or me this is negligible and clearly outweighed by the benefit of al=
most=20
total reliability.
In addition, the whole procedure is at least not slower than before.

More test-results in the thread for Bug 47931 (posted by "Jay").

I am not sure whether my post or the patch conform to conventions here=20
but in view of the potential improvement in s2disk I thought=20
I'd give it a try.

Reviews/comments/advice welcome.


Rainer Fiebig



Signed-off-by: J. Rainer Fiebig <j.r.f@t-online.de>

--- linux-3.16.2/kernel/power/snapshot.orig     2014-08-04 00:25:02.000=
000000=20
+0200
+++ linux-3.16.2/kernel/power/snapshot.c        2014-10-28 20:49:32.000=
000000=20
+0100
@@ -1332,6 +1332,13 @@ int hibernate_preallocate_memory(void)
=20
        /* Count the number of saveable data pages. */
        save_highmem =3D count_highmem_pages();
+
+       /*=20
+        * Free memory. About 50% of used data pages seems sufficient=20
+        * without exerting too much pressure. This is done on every s2=
disk.
+        */
+       shrink_all_memory(count_data_pages() / 2);
+
        saveable =3D count_data_pages();
=20
        /*
@@ -1389,14 +1396,6 @@ int hibernate_preallocate_memory(void)
                size =3D min_t(unsigned long, pages, max_size);
=20
        /*
-        * Let the memory management subsystem know that we're going to=
 need a
-        * large number of page frames to allocate and make it free som=
e=20
memory.
-        * NOTE: If this is not done, performance will be hurt badly in=
 some
-        * test cases.
-        */
-       shrink_all_memory(saveable - size);
-
-       /*
         * The number of saveable pages in memory was too high, so appl=
y some
         * pressure to decrease it.  First, make room for the largest p=
ossible
         * image and fail if that doesn't work.  Next, try to decrease =
the=20
size
--
