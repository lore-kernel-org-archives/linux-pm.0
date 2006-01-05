From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Thu, 5 Jan 2006 23:45:31 +0100
Message-ID: <20060105224531.GK2095@elf.ucw.cz>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD5D@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============50896847597435779=="
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
Cc: akpm@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============50896847597435779==
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k05MjkDZ006879

On =C4=8Ct 05-01-06 17:21:38, Preece Scott-PREECE wrote:
> We do have multiple system-level low-power modes. I believe today they
> differ in turning whole devices on or off, but there are some of those
> devices that could be put in reduced-function/lowered-speed modes if we
> were ready to use a finer-grained distinction.

I think we were talking multiple off modes for _single device_. It is
good to know that even cellphones can get away with whole devices
on/off today.
								Pavel

--=20
Thanks, Sharp!

--===============50896847597435779==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============50896847597435779==--
