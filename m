From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Bug#354254: hibernate: Suspend to disk doesn't work:
	cannot find swap device
Date: Fri, 24 Feb 2006 20:42:42 +0100
Message-ID: <200602242042.42500.rjw@sisk.pl>
References: <E1FCiR6-0002no-00@porton.narod.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============85502784903889362=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <E1FCiR6-0002no-00@porton.narod.ru>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org, Victor Porton <porton@ex-code.com>, 354254@bugs.debian.org
Cc: Debian Bug Tracking System <submit@bugs.debian.org>
List-Id: linux-pm@vger.kernel.org

--===============85502784903889362==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Friday 24 February 2006 20:17, Victor Porton wrote:
> Package: hibernate
> Version: 1.12-1
> Severity: normal
> X-Debbugs-CC: pavel@suse.cz, linux-pm@osdl.org
> 
> Suspend to disk does not work for me with the following dmesg message:
> 
> PM: writing image.
> swsusp: cannot find swap device, try swapon -a.
> 
> Yes, my swap was turned on and I checked it again. I HAVE run swapon -a.
> $ swapon -s
> Filename                                Type            Size    Used   
> Priority
> /dev/hda2                               partition       254008  0       -1
> 
> I run 2.6.15.4 kernel (not from Debian distribution).

I think you haven't used the "resume=<your_swap_partition>" kernel command
line argument, which is mandatory for suspend with this kernel.

Greetings,
Rafael

--===============85502784903889362==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============85502784903889362==--
