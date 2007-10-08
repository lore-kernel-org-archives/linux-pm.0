From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] Documentation for USB power management
Date: Mon, 8 Oct 2007 08:40:49 +0200
Message-ID: <200710080840.49451.oliver__35237.1260560632$1191825609$gmane$org@neukum.org>
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
> +External suspend calls should never be allowed to fail in this way,
> +only autosuspend calls. =A0The driver can tell them apart by checking
> +udev->auto_pm; this flag will be set to 1 for internal PM events

This is a bit unclear, as suspend methods are called with interface
pointers. I think you need to elaborate.

	Regards
		Oliver
