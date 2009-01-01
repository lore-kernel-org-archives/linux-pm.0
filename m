From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Thu, 1 Jan 2009 14:39:41 +0000 (GMT)
Message-ID: <120849.67182.qm__2135.6473480866$1230910721$gmane$org@web23104.mail.ird.yahoo.com>
References: <69e28c910901010540r5e79431cjf6ad1a76f06ff0fd@mail.gmail.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <69e28c910901010540r5e79431cjf6ad1a76f06ff0fd@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, =?iso-8859-1?Q?Stefanik_G=E1bor?= <netrolller.3d@gmail.com>
Cc: Bob Copeland <me@bobcopeland.com>, USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, linux-pm@lists.linux-foundation.org, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

--- On Thu, 1/1/09, Stefanik G=E1bor <netrolller.3d@gmail.com> wrote:

> On Thu, Jan 1, 2009 at 2:07 PM, Alan Jenkins
> <alan-jenkins@tuffmail.co.uk> wrote:

> > I think it's a B device.
> >
> > phy0: hwaddr 00:1b:2f:76:02:bc, RTL8187vB (default) V1
> + rtl8225z2

> That is an RTL8187L, rev. B. It is not an RTL8187B.

Yes, that's the (older) non-B device. B devices says RTL8187Bv{B,D,E} . wit=
h a B before the 7; I have a rev E .The B device and the non-B device while=
 similiar enough to share some driver code, are different enough that
they might suspend/resume differently - they do probe/init slightly differe=
ntly. Besides, I think all the people who recently worked on that code are =
B-device owners, with maybe Larry who probably owns both types (or a few).

Hin-Tak


      =
