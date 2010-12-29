From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Wed, 29 Dec 2010 10:01:40 +0200
Message-ID: <AANLkTi=QT1thWxy94=imJhbbcXQ1CD36=PnkAyaaA6Hj__30245.9728009582$1293609787$gmane$org@mail.gmail.com>
References: <AANLkTim7pGtO=vjKmA_3O74Kwvio124cgoaMeUSB70dW@mail.gmail.com>
	<Pine.LNX.4.44L0.1012281541580.22998-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1012281541580.22998-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 28, 2010 at 11:46 PM, Alan Stern <stern@rowland.harvard.edu> wr=
ote:
> Similarly, during system suspend mmc_suspend_host() should be
> responsible for doing all the necessary power-down operations. =A0Runtime
> PM is completely out of the picture at this time. =A0And this should be
> independent of mac80211 -- in fact, the card should be powered down
> appropriately even if the kernel doesn't have a mac80211 layer.

And it is.

But in order to boot the firmware on resume, we need to reset the
device. And if system suspend has been cancelled before
mmc_power_off() was invoked, we will not be able to. So, in this case
too, the driver will have to power the device off.

It all really boils down to the same solution - we will always have to
bypass runtime PM and directly control the power of the device.
