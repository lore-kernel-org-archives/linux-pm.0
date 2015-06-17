From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.1-rc7: Xorg broken after resume on thinkpad T40p, radeon
 problem?
Date: Wed, 17 Jun 2015 14:49:49 +0200
Message-ID: <20150617124949.GA22953@amd>
References: <20150617124347.GA22879@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150617124347.GA22879@amd>
Sender: linux-acpi-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, christian.koenig@amd.com, alexander.deucher@amd.com, rjw@rjwysocki.net, lenb@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed 2015-06-17 14:43:47, Pavel Machek wrote:
> Hi!
> 
> Video is broken on thinkpad T40p after resume from suspend. (In X
> only, text console still works.)
> 
> Maybe this is related?
> 
> [ 5430.193071] radeon 0000:01:00.0: putting AGP V2 device into 4x mode
> [ 5430.193107] radeon 0000:01:00.0: GTT: 256M 0xD0000000 - 0xDFFFFFFF
> [ 5430.214670] radeon 0000:01:00.0: WB disabled
> [ 5430.214675] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x00000000d0000000 and cpu addr 0xf841a000
> [ 5430.214721] [drm] radeon: ring at 0x00000000D0001000
> [ 5430.370867] [drm:r100_ring_test] *ERROR* radeon: ring test failed (scratch(0x15E8)=0xCAFEDEAD)
> [ 5430.370869] [drm:r100_cp_init] *ERROR* radeon: cp isn't working (-22).
> [ 5430.370872] radeon 0000:01:00.0: failed initializing CP (-22).
> 
> Hibernation works well here, including X. (Which has small glitch with
> mouse cursor being corrupted until it is changed by application).
>

3.16.0-4-686-pae Debian 3.16.7-cktt11-1 kernel seems to have same
problem, with same scratch(0x15E8)=0xCAFEDEAD message... so this is
not "new" problem...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
