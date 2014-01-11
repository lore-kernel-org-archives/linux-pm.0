From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Allow runtime suspend during system resume
Date: Fri, 10 Jan 2014 21:08:30 -0500
Message-ID: <52D0A79E.6080905@ubuntu.com>
References: <Pine.LNX.4.44L0.1401101012400.1399-100000@iolanthe.rowland.org> <66174540.xyTk2QCVeJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:45957 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbaAKCIe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2014 21:08:34 -0500
In-Reply-To: <66174540.xyTk2QCVeJ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>
Cc: Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 01/10/2014 06:02 PM, Rafael J. Wysocki wrote:
> So, my opinion is that the runtime PM internal information should
> be made reflect the actual (and/or desirable) state of things
> before it is re-enabled, which practically means in the
> .resume_noirq()/.resume_early() time frame.
> 
> Doing it after that might actually work, but is questionable from
> the overall consistency perspective (it basically would mean that
> we ran with wrong runtime PM data for a while after we'd re-enabled
> it and before it got adjusted, so we shouldn't have re-enabled it
> in the first place).

But we don't want to block the system resume path for too long while
we figure out what the correct state is.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJS0KedAAoJEI5FoCIzSKrw41EH/0phrR8FKj2D8H2YidMluZ0/
0crckeYkz4VMEkxMrzjnFl1sxwaWLfYW1GOpJ6FnGZqArjLr0GktOHBJfVTWqNqI
bNIFW5rKX/JKgns3Nmv1Zx5twxHuIfVtAF2mjgorabyKyRpaVwsiZa9ogLgBnUVr
ipLYX1mBRvmoMPDHYB3/wrefc4c0Eg4n1O24/wVhehxtsBCeN9BKUUEcIRvkiRUj
FwMmWXuZMlTGK2LhjmgCMuH7Ea9r8sAJWUkGA8zJJLuS8y7kK9grUwAW5IhfrJGH
Wg5sBce8sKhoX7h5gze+rVktrM1B4DDzEt4J356lmIjfeQ75rUrHMzEDvzh021M=
=+ubG
-----END PGP SIGNATURE-----
