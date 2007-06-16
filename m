From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.22-rc4 XFS fails after hibernate/resume
Date: Sun, 17 Jun 2007 00:47:19 +0200
Message-ID: <200706170047.20559.rjw@sisk.pl>
References: <46744065.6060605@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46744065.6060605@dgreaves.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Greaves <david@dgreaves.com>
Cc: LVM general discussion and development <linux-lvm@redhat.com>, linux-pm <linux-pm@lists.osdl.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
List-Id: linux-pm@vger.kernel.org

On Saturday, 16 June 2007 21:56, David Greaves wrote:
> This isn't a regression.
> 
> I was seeing these problems on 2.6.21 (but 22 was in -rc so I waited to try it).
> I tried 2.6.22-rc4 (with Tejun's patches) to see if it had improved - no.
> 
> Note this is a different (desktop) machine to that involved my recent bugs.
> 
> The machine will work for days (continually powered up) without a problem and 
> then exhibits a filesystem failure within minutes of a resume.
> 
> I know xfs/raid are OK with hibernate. Is lvm?
> 
> The root filesystem is xfs on raid1 and that doesn't seem to have any problems.

What is the partition that's showing problems?  How's it set up, on how many
drives etc.?

Also, is the dmesg output below from right after the resume?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
