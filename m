From: Victor Porton <porton@ex-code.com>
Subject: Re: Bug#354254: hibernate: Suspend to disk doesn't work:
	cannot find swap device
Date: Sat, 25 Feb 2006 05:39:19 +0500 (YEKT)
Message-ID: <E1FCnSx-0000u7-00@porton.narod.ru>
References: <200602242042.42500.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============51726141926425218=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602242042.42500.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Debian Bug Tracking System <submit@bugs.debian.org>, 354254@bugs.debian.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============51726141926425218==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 24-Feb-2006 Rafael J. Wysocki wrote:
>> Suspend to disk does not work for me with the following dmesg message:
>> 
>> PM: writing image.
>> swsusp: cannot find swap device, try swapon -a.
>> 
> I think you haven't used the "resume=<your_swap_partition>" kernel command
> line argument, which is mandatory for suspend with this kernel.

I have used resume=/dev/swap

/dev/swap is a symlink to /dev/hda2

-- 
Victor Porton (porton@ex-code.com) - http://porton.ex-code.com

--===============51726141926425218==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============51726141926425218==--
