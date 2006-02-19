From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH 3/5] [pm] Respect the actual device power
	states in sysfs interface
Date: Sun, 19 Feb 2006 15:59:25 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
	<20060218155543.GE5658@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============39157266319921002=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060218155543.GE5658@openzaurus.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============39157266319921002==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sat, 18 Feb 2006, Pavel Machek wrote:

> Hi!
>
> > Fix the per-device state file to respect the actual state that
> > is reported by the device, or written to the file.
>
> Can we let "state" file die? You actually suggested that at one point.
>
> I do not think passing states in u32 is good idea. New interface that passes
> state as string would probably be better.

Yup, in the future that will be better. For now, let's work with what we
got and fix 2.6.16 to be compatible with previous versions..

Thanks,


	Pat


--===============39157266319921002==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============39157266319921002==--
