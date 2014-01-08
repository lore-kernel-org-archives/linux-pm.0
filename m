From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Allow runtime suspend during system resume
Date: Wed, 08 Jan 2014 16:17:29 -0500
Message-ID: <52CDC069.6050703@ubuntu.com>
References: <Pine.LNX.4.44L0.1401081522240.1659-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:43119 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756768AbaAHVRb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2014 16:17:31 -0500
In-Reply-To: <Pine.LNX.4.44L0.1401081522240.1659-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/8/2014 3:44 PM, Alan Stern wrote:
> Right now the PM core does pm_runtime_get_noresume() during the
> prepare phase of system sleep, and pm_runtime_put() during the
> complete phase. Maybe we should cut down the range of coverage.
> 
> For example, we could do the pm_runtime_put() during dpm_resume(),
> or even earlier.  That way, the resume routine could do something
> like:
> 
> if (!pm_runtime_in_use(dev)) { pm_runtime_disable(dev); 
> pm_runtime_set_suspended(dev); pm_runtime_enable(dev); return 0; }
> 

I'm a little unclear on the problem you are describing.  Is it just
with pm_runtime_in_use()?  Because in one of my earlier patch
iterations, I had used the disable/set_suspended/enable to force the
device into suspend without checking runtime_in_use.  It worked, but
that allowed the port device to auto suspend since its use counter
dropped to zero, so I couldn't issue the REQUEST SENSE command
disable/set_active/enable to reverse the process ( since the port was
suspended ).


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSzcBnAAoJEI5FoCIzSKrw/LQH/A7voCeYxm8fU8k2Uxw2yTNO
dZjgzTVoETQAif3iNtbMaXy8lF4GrqRVtGJIF683eK5jn5zUTSPggaxFXUqFGRAM
sJHfxxNaJKThCRGBrZg6NEIoushNLlC/XdwY2XEt+ee2aVdNbSs2Up7IOdkuqrjc
1uPThOoBbgb3GE/5FlLgfhouQhdIXYhh7r7xu1JaJ0DVhtwPMWdMFBLos2qdsMk4
5uPBLNhrQyHt2mQvEQj4meVwqun+SsbzWtgiP3Nk5MSCCRa4LHVa0nfb2N6+ee8+
Q3/kwoDDyghvJeoi4K7iWLFfFjynTchvxfzInItnYK5TKJiU1rf2En+qIT2g9BQ=
=Fkc4
-----END PGP SIGNATURE-----
