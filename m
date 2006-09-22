From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [PATCH] PowerOP, PowerOP Core, 1/2
Date: Fri, 22 Sep 2006 15:34:50 -0500 (CDT)
Message-ID: <200609222034.k8MKYoDK008487@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Pavel Machek's message of Fri, 22 Sep 2006 16:11:27 +0200
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@ucw.cz
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Note that I don't think PowerOp would cover all devices. In fact, I
think most devices would remain autonomous or controlled as part of
specific subsystems. The only things that PowerOp would bundle together
would be things that aren't independent (and may not even be visible as
"devices" in the usual Linux sense), but that have to be managed
together in changing frequency/voltage. At least, that's the way I
imagined it would work.

scott


| From pavel@ucw.cz Fri Sep 22 09:13:53 2006
| =

| Hi!
| =

| > Hmm. If you assume the CPUs in an SMP system can be in different
| > operating points, this would (as Pavel pointed out) result in an
| > explosion of operating points.
| =

| Problem is not only CPUs, devices are mostly independent in PC
| case... it would be nice to solve that problem with same approach.
| =

| 								Pavel
| -- =

| (english) http://www.livejournal.com/~pavelmachek
| (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
| =


-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
