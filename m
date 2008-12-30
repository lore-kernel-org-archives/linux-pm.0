From: Oliver Neukum <oliver@neukum.org>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Tue, 30 Dec 2008 19:05:44 +0100
Message-ID: <200812301905.46215.oliver__17324.8551589952$1230660377$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0812301220090.2386-100000@iolanthe.rowland.org>
	<495A5AE5.1040902@tuffmail.co.uk> <495A5FEC.5070608@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <495A5FEC.5070608@lwfinger.net>
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
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Bob Copeland <me@bobcopeland.com>, USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Hin-Tak Leung <htl10@users.sourceforge.net>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 30. Dezember 2008 18:52:44 schrieb Larry Finger:
> Alan Jenkins wrote:
> > That won't fix hibernation though. =A0The disconnect method can still g=
et
> > called in resume from hibernation, before the workqueue gets unfrozen. =

> > To be honest, I'm far more interested in suspend-to-disk than
> > suspend-to-ram.
> =

> Does this patch fix your problem? It works here, but I only did one
> test. The patch is for wireless-testing.

Did you test STD or STR?

	Regards
		Oliver
