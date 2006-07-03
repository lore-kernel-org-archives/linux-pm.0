From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: swsusp regression
Date: Tue, 04 Jul 2006 00:53:02 +0159
Message-ID: <44A99FE5.6020806@gmail.com>
References: <44A99DFB.50106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <44A99DFB.50106@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Jiri Slaby napsal(a):
> Hello,
> =

> when suspending machine with hyperthreading, only Freezing cpus appears a=
nd then

Note: suspending to disk; done by:
echo reboot > /sys/power/disk
echo disk > /sys/power/state

> it loops somewhere. I tried to catch some more info by pressing sysrq-p. =
Here
> are some captures:
> http://www.fi.muni.cz/~xslaby/sklad/03072006074.gif
> http://www.fi.muni.cz/~xslaby/sklad/03072006075.gif

One more from some previous kernels (cutted sysrq-t):
http://www.fi.muni.cz/~xslaby/sklad/22062006046.jpg

regards,
-- =

Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
