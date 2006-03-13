From: Pavel Machek <pavel@ucw.cz>
Subject: Re: standby to disk transition
Date: Mon, 13 Mar 2006 09:30:38 +0100
Message-ID: <20060313083037.GA3495@elf.ucw.cz>
References: <E1FIctI-0000jE-00@porton.narod.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============23138184844698939=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <E1FIctI-0000jE-00@porton.narod.ru>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Victor Porton,,," <porton@ex-code.com>
Cc: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============23138184844698939==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Po 13-03-06 07:34:36, Victor Porton,,, wrote:
> There should be something such which would cause (after user
> specified timeout, e.g. a hour) automatically switch the
> system from standby to suspend to disk (or suspend to mem).
....
> Or as a possible alternative, we could suspend SIMULTANEOUSLY
> to disk and to mem (with switching into suspend-to-disk by
> timeout), to have both quick restoration and automatically
> fully turning it off.

Yep, it would be nice.

Does that mean you are working on it and will send me a patch? Do you
want help coding?
							Pavel
-- 
105:        bool bUnix = Environment.OSVersion.ToString().IndexOf( "Unix" ) != -1;

--===============23138184844698939==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============23138184844698939==--
