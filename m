From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] Documentation for USB power management
Date: Mon, 8 Oct 2007 08:34:53 +0200
Message-ID: <200710080834.53959.oliver__7926.13537419147$1191825323$gmane$org@neukum.org>
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
> +It is worth mentioning that many USB drivers don't support
> +autosuspend. =A0In fact, at the time of this writing (Linux 2.6.23) th=
e
> +only drivers which do support it are the hub driver, kaweth, usblp,
> +usblcd, usb-skeleton (which doesn't count), and usb-storage. =A0If a

Storage no longer does.
You forgot the asix etherne driver.

	Regards
		Oliver
