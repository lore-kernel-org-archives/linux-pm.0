From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Allow runtime suspend during system resume
Date: Thu, 09 Jan 2014 11:30:50 -0500
Message-ID: <52CECEBA.5090908@ubuntu.com>
References: <Pine.LNX.4.44L0.1401091057550.1493-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:61917 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbaAIQaw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 11:30:52 -0500
In-Reply-To: <Pine.LNX.4.44L0.1401091057550.1493-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/9/2014 11:08 AM, Alan Stern wrote:
> The code will be restructured as part of the asynchronous spin-up 
> change.  The resume routine would then look more like this:
> 
> bool test_spinning = !pm_runtime_in_use(dev);
> 
> pm_runtime_disable(dev); if (test_spinning) 
> pm_runtime_set_suspended(dev); else pm_runtime_set_active(dev); 
> pm_runtime_enable(dev);
> 
> start_async_spin_up(dev, test_spinning); return 0;
> 
> The asynchronous routine would skip the initial test if its second
>  argument is nonzero, and proceed directly to spin-up the disk.

It isn't enough to background the spin up; the TEST will block, so it
needs to be async as well.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSzs66AAoJEI5FoCIzSKrwY40H/1gAfH5KxfXvr9gHGMOHAdiw
VwUNKJTnADrEREOTEgWSPH8/VYyK2aFPjiGlWKvmZXMNC0CYLPRInSbhLx0cH4x1
uvezYnvVno/xME8QlLTqzVuQIrk3TKjyrd0rCBpj3YvAAyDy8TSGrJZfDAUixZkP
zoahqzIthPE52DirixVBYIamsDOZltHOjK2HbfTHZXo9m+dxQirDqL/ClQivt3Gq
e0IhRDEXsEb1b4ICQztuqNAp2BV57IzIHCd83+CTd/hkPalHFxJv6Y26IGYrORSZ
CRtXWMYiGs2/cIElSpIIQDUL60niqfFPaxsGRCT+AISwu/f4TRzAo2t/t+Vaa6c=
=aR9i
-----END PGP SIGNATURE-----
