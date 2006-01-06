From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Fri, 6 Jan 2006 16:03:34 +0100
Message-ID: <20060106150334.GB20242@isilmar.linta.de>
References: <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
	<20051227220533.GA1914@elf.ucw.cz>
	<Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
	<20060104213405.GC1761@elf.ucw.cz>
	<Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
	<20060105215528.GF2095@elf.ucw.cz>
	<20060105221334.GA925@isilmar.linta.de>
	<20060105222338.GG2095@elf.ucw.cz>
	<20060105222705.GA12242@isilmar.linta.de>
	<20060106003806.GA29182@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============39880197440184473=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060106003806.GA29182@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============39880197440184473==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 05, 2006 at 04:38:06PM -0800, Greg KH wrote:
> > NB: it will break one day, one way or another, when gregkh makes the
> > /sys/class -> /sys/devices conversion. However, I'd want to try not to break
> > the new pcmciautils userspace too often...
> 
> Why would the conversion that I'm working on break this userspace code?
> You are only using the device directory, which will not change at all.

Actually, pcmciautils uses both paths starting with
/sys/bus/pcmcia/devices/ and /sys/class/pcmcia_socket/pcmcia_socket%d/ --
and I was expecting that the latter path won't be available somewhen in
future?

Thanks,
	Dominik

--===============39880197440184473==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============39880197440184473==--
