From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: __releases and __acquires macros in compiler.h
Date: Wed, 3 May 2006 22:52:51 -0700
Message-ID: <20060503225251.759c1470.rdunlap@xenotime.net>
References: <380D9721A8E2114485644D71E87C6AB201CCBC26@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============090166041491648086=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB201CCBC26@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rasmit.ranjan@wipro.com
Cc: linux-kernel-digest@lists.us.dell.com, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============090166041491648086==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 May 2006 11:13:20 +0530 rasmit.ranjan@wipro.com wrote:

> Hi all,
>     I came across two macros __releases and __acquires defined in
> compiler.h.
> Can anyone please tell me the exact use of these two macros.

They are for the sparse static checker to count locks released
and acquired, to make sure that they are balanced.

---
~Randy

--===============090166041491648086==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============090166041491648086==--
