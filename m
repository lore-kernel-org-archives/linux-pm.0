From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PowerOP 2/3: Intel Centrino support
Date: Wed, 10 Aug 2005 12:01:33 +0200
Message-ID: <20050810100133.GA1945@elf.ucw.cz>
References: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============53438091708394664=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
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

--===============53438091708394664==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Minimal PowerOP support for Intel Enhanced Speedstep "Centrino"
> notebooks.  These systems run at an operating point comprised of a cpu
> frequency and a core voltage.  The voltage could be set from the values
> recommended in the datasheets if left unspecified (-1) in the operating
> point, as cpufreq does.

Eh? I thought these are handled okay by cpufreq already? What is
advantage of this over cpufreq?
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============53438091708394664==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============53438091708394664==--
