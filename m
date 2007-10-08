From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] Documentation for USB power management
Date: Mon, 8 Oct 2007 08:38:33 +0200
Message-ID: <200710080838.33297.oliver__49664.9912013256$1191825485$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0710061607420.2264-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0710061607420.2264-100000@netrider.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

Am Samstag 06 Oktober 2007 schrieb Alan Stern:
> +=A0=A0=A0=A0=A0=A0=A0Other parts of the driver interface
> +=A0=A0=A0=A0=A0=A0=A0-----------------------------------
> +
> +Sometimes a driver needs to make sure that remote wakeup is enabled
> +during autosuspend. =A0For example, there's not much point
> +autosuspending a keyboard if the user can't cause the keyboard to do a
> +remote wakeup by typing on it. =A0If the driver sets
> +intf->needs_remote_wakeup to 1, the kernel won't autosuspend the
> +device if remote wakeup isn't available or has been disabled through
> +the power/wakeup attribute.

You should mention that a driver has to make sure that the device is
awake for this to have immediate effect.

	Regards
		Oliver
