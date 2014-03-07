From: Manuel Krause <manuelkrause@netscape.net>
Subject: 3.13.?: Strange / dangerous fan policy...
Date: Fri, 07 Mar 2014 20:33:02 +0100
Message-ID: <531A1EEE.9090101@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from omr-d10.mx.aol.com ([205.188.108.134]:53707 "EHLO
	omr-d10.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbaCGTd2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Mar 2014 14:33:28 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Please have a short look at the following BUG report + the=20
comments -- this message here is a kind of FWD-ing it:
https://bugs.archlinux.org/task/39005

I came late to test kernel 3.13 with the .5 one, as it was the=20
time that the related -CK/BFS patch became available.

I'm not using Archlinux, but openSUSE, and my problems are quite=20
the same. Especially these with smelling melting plastics.

My own reports went to Con Kolivas' Blog first:
"I get weird temperatures and abrupt 100% fan actions with=20
vanilla 3.13.5 with this CK and most recent BFQ at my HP Notebook.
In gkrellm the highest T had been @74=B0C, so far (3.12.13), and is=20
now growing to 94=B0C. Then, the fan goes to 100% for 10~30secs=20
cooling it to approx. 82=B0C.
That is not good, if I compare 74 to 94 =B0C.
Have I missed a .CONFIG option for 3.13, especially?"

I'd get the same without (Con's && BFQ's) patches.

Machine:           HP Notebook with Core2Duo CPU (Penryn)
Distro:            openSUSE 13.1, 64bit, continuously updated
Desktop:           KDE 4.12.3
MESA & drm & Xorg: most recent ones from:
http://download.opensuse.org/repositories/home:/pontostroy:/X11/openSUS=
E_13.1/x86_64/

Current kernel:    3.13.6 vanilla from openSUSE repos, with
                    -ck1 and BFQ patches
Same behaviour:    without these patches

Last good kernel:  3.12.13 vanilla + CK2 + BFQ


Please, _always_CC_me_ -- as I'm not on the linux-kernel /=20
linux-pm mailing lists.

And please, if you know any person in charge of this -- lead this=20
message to him/her.

Thank you in advance and best regards,
Manuel Krause

