From: Jiri Slaby <jirislaby@gmail.com>
Subject: swsusp regression [Was: 2.6.17-mm1]
Date: Wed, 21 Jun 2006 23:47:46 +0159
Message-ID: <4499BE99.6010508@gmail.com>
References: <20060621034857.35cfe36f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-pm@osdl.org, pingc@wacom.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Andrew Morton napsal(a):
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.=
17-mm1/

[32512.214000] Suspending device usbdev3.2_ep81
[32512.214040] Suspending device 3-2:1.0
[32512.214081] wacom 3-2:1.0: no suspend for driver wacom?
[32512.214128] Suspending device usbdev3.2_ep00
[32512.214169] Suspending device 3-2
[32512.214209] suspend_device(): usb_generic_suspend+0x0/0x128() returns -16
[32512.214319] Could not suspend device 3-2: error -16
[32512.214361] wacom 3-2:1.0: no resume for driver wacom?
[32512.242552] Some devices failed to suspend

Bus 003 Device 002: ID 056a:0011 Wacom Co., Ltd Graphire 2

Wacom messages are not new, but it now causes not suspending.

2.6.17-rc6-mm2 was OK.

Is there any more info needed?

-- =

Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
