From: Patrick Mochel <mochel@digitalimplant.org>
Subject: RE: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Thu, 5 Jan 2006 16:02:29 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0601051558100.10428-100000@monsoon.he.net>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD5D@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1062551654343542=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD5D@de01exm64.ds.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Preece Scott-PREECE <scott.preece@motorola.com>
Cc: akpm@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============1062551654343542==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 5 Jan 2006, Preece Scott-PREECE wrote:

> This is, of course, in an embedded framework rather than a desktop
> framework - we suspend and wakeup automatically, not via user
> intervention. Answering a question asked in another piece of mail, we
> have roughly a dozen different devices that cause the system to wakeup -
> keypad press, touchscreen touch, flip open/close, etc.

Hmm, it would be nice if that comment was in reply to the email in which
it came. At least if it was in the same thread..

Many systems have > 1 _possible_ wakeup devices (keyboard, touchscreen,
lid, etc). You implied that when a system wakes up, there could be > 1
device that actually woke the system up, which is in direct conflict with
what I've always assumed - that when a system wakes up, it is caused by a
single device (and if there were multiple events, like a key press *and* a
mouse movement, it's doesn't really matter)..

Thanks,


	Patrick


--===============1062551654343542==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1062551654343542==--
