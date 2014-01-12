From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Allow runtime suspend during system resume
Date: Sat, 11 Jan 2014 20:50:19 -0500
Message-ID: <52D1F4DB.2060402@ubuntu.com>
References: <Pine.LNX.4.44L0.1401111735050.16586-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:56723 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaALBuW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 11 Jan 2014 20:50:22 -0500
In-Reply-To: <Pine.LNX.4.44L0.1401111735050.16586-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 01/11/2014 05:50 PM, Alan Stern wrote:
> We won't.  The resume_early routine will set the status to
> RPM_ACTIVE or RPM_SUSPENDED, according to the result from 
> pm_runtime_usage_during_sleep.  It will also do a
> pm_runtime_get_sync on the disk's parent, to prevent the parent
> from going into runtime suspend before the async routine can run.
> 
> Then the async routine will do the following:
> 
> If the status is RPM_ACTIVE, spin up the disk.
> 
> Else (the status is RPM_SUSPENDED) check whether the disk has spun
> up by itself.  If it has, or if you can't tell, call 
> pm_runtime_resume to set the status correctly and do an explicit
> spin-up.
> 
> Call pm_runtime_put_sync on the parent.

I see now... thanks.

> I think this will give the desired result.  But there is one
> potential problem: If the disk has a child device (such as a
> partition) and the child's driver needs to do I/O as part of its
> resume routine, the I/O is likely to hang if the disk is runtime
> suspended.  However, I don't know of any child devices like this.

Probably should check dm and md to see if they do IO in their resume.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJS0fTbAAoJEI5FoCIzSKrwTVoH/3Cl4ZEmE+5aUJX5+mCGmoPD
Ap+UHe517qsfDWwKaDqURTcXaZOqMfbk71jdTCAIIVTSPB95NWFQg3d/XpWAVY29
yoXdUj28WHTlgtfhtqa92K7lImOijxJ/32myEK9/+dQBDXXnG4n+jt1eL+vo9Rhy
vlcAJLKcCsL4SpDD8z/N2lvsmJ5F1vIB5SkM7GiyaR3HHfRIM3hzV4JErtHozgWE
x2zNfD6DXk7CR3GnISq2bznIYvRlfsmvzwCjfJ3AYBJdtFQmuwMDznaVKlCpy/Ya
G07n0HqghB3ZYseZLZt8HyB/men72SZolJCTb/UnkODTsymq9+6J3XrJ6bb29Vc=
=V+EM
-----END PGP SIGNATURE-----
