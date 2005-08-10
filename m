From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PowerOP 3/3: Intel Centrino cpufreq integration
Date: Wed, 10 Aug 2005 12:03:39 +0200
Message-ID: <20050810100339.GB1945@elf.ucw.cz>
References: <20050809025727.GD25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12429388947023523=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050809025727.GD25064@slurryseal.ddns.mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Todd Poynor <tpoynor@mvista.com>
Cc: cpufreq@lists.linux.org.uk, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============12429388947023523==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> A minimal example of modifying cpufreq to use PowerOP for reading and
> writing power parameters on Intel Centrino platforms.  It would be
> possible to move voltage table lookups to the PowerOP layer.

Aha, ok, sorry for my previous comment. It looks like powerop
framework can cleanup speedstep-centrino a tiny bit. Where else is it
used?

								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============12429388947023523==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============12429388947023523==--
