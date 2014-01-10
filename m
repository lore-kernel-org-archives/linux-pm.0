From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Allow runtime suspend during system resume
Date: Thu, 09 Jan 2014 20:55:06 -0500
Message-ID: <52CF52FA.3030001@ubuntu.com>
References: <Pine.LNX.4.44L0.1401091015200.1493-100000@iolanthe.rowland.org> <3652290.QccRAxIbQ5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:51208 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbaAJBzJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 20:55:09 -0500
In-Reply-To: <3652290.QccRAxIbQ5@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>
Cc: Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 01/09/2014 08:25 PM, Rafael J. Wysocki wrote:
> That looks reasonable, but in .resume_early() you can do it like
> this I think:
> 
> bool disk_spinning = disk_is_spinning(dev); int rc = 0;
> 
> if (!pm_runtime_in_use(dev) && !disk_spinning) { 
> pm_runtime_set_suspended(dev); } else { 
> pm_runtime_set_active(dev); if (!disk_spinning) rc =
> spin_up_the_disk(dev); }

You're not allowed to call pm_runtime_set_{suspended,active} without
disabling runtime pm.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJSz1L6AAoJEI5FoCIzSKrwNWoIAKXZ6E7Vcrhbf7odxxdp11nq
vmr76+RkywUvJWDeRkq5IrgXfepyc/tEdQURNXcUvquOwbxX6NfH/Sb4DYZ+UUva
nJ9Po/vCyQAZgXodK3In7cteY4NvZLGVt9m3JkaYHKs3vkDriusSLMI1ghVNZIkW
X/VrVWhlnl9XNYWzFZuCs3ccsYpDfQ0akrxqFDoEh/mj5UUVkVXQt+JpkGPuUDD4
8yR3omZ+OFwnjqHLtzC8AOI59wujY2NPjoohQH4Rd+JTJEmAu9Ml5fqkPg90z9b2
C2mnpkEBoDEO4L1pDrD1jmxCwZQApf0qFWfu8qo+OR/VtMnxF5Cpkd+O5H+0OQg=
=Ksl4
-----END PGP SIGNATURE-----
