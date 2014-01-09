From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Allow runtime suspend during system resume
Date: Thu, 09 Jan 2014 10:50:46 -0500
Message-ID: <52CEC556.7030405@ubuntu.com>
References: <Pine.LNX.4.44L0.1401091015200.1493-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:56103 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaAIPus (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 10:50:48 -0500
In-Reply-To: <Pine.LNX.4.44L0.1401091015200.1493-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/9/2014 10:32 AM, Alan Stern wrote:
> I had in mind something more like this for the driver's .resume
> (or .resume_early) routine:
> 
> bool leave_suspended = false; int rc = 0;
> 
> if (!pm_runtime_in_use(dev) && !disk_is_spinning(dev)) 
> leave_suspended = true; else rc = spin_up_the_disk(dev);
> 
> if (rc == 0) { pm_runtime_disable(dev); if (leave_suspended) 
> pm_runtime_set_suspended(dev); else pm_runtime_set_active(dev); 
> pm_runtime_enable(dev); } return rc;

We also don't want to block the resume path while the REQUEST SENSE
runs, since it typically takes 10 seconds or so on normal ATA disks.
Thus, the resume or resume early needs to be able to return with the
device left in the transitioning state and complete or abort the
transition later.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSzsVVAAoJEI5FoCIzSKrwLGAIAJj3GvPEcwtFvkJ6oAX+4fbf
z75OHkOkKtwOTY1SvqpgyYUMdrsTLRYO5ZPCCzZemow6s24xjEhtHVYONKogZ8Rv
lYzFpsZhWd7pLjHm5PDUSbEJiOvx9Ba+6JbRYGl9rInv2PdJOSscEpN+4a0/bvGU
F72tUfYI58su0RHcee9xXFRBOZkM61DCxNNXAyr+SHa7fIJi5jKrlNSbHPzBXAo0
g/qw8IY86a3SWE4cOGIfsrtL8GpmbwFNkT+BHWhaRlj2wj2VTP5FTZrOHndNL7pU
WC29Qxg2cKhSgm15BhNw3ESjn/3rdFaHsV96ietFKMlavXDqRmmwPsTmNK8Pbuo=
=5AE6
-----END PGP SIGNATURE-----
