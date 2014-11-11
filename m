From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V2 12/12] MIPS: Loongson: Make CPUFreq usable for
 Loongson-3
Date: Tue, 11 Nov 2014 12:07:02 +0100
Message-ID: <20141111110702.GA28822@linux-mips.org>
References: <1415081928-25899-1-git-send-email-chenhc@lemote.com>
 <20141111105748.GK27259@linux-mips.org>
 <CAAhV-H7H+7TYyvbecaS6C1NEq7DEnjez2Z_eHnpix0+m_5FDoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <CAAhV-H7H+7TYyvbecaS6C1NEq7DEnjez2Z_eHnpix0+m_5FDoA@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Huacai Chen <chenhc@lemote.com>
Cc: John Crispin <john@phrozen.org>, "Steven J. Hill" <Steven.Hill@imgtec.com>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-pm@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Hongliang Tao <taohl@lemote.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 11, 2014 at 07:02:48PM +0800, Huacai Chen wrote:

> Loops_per_jiffy is set on startup and doesn't change later. It reflect
> the maximum value frequency, but for CPU hotplug, a new online CPU may
> not run at the maximum frequency (remain the old value before it is
> offline).

As suspected.  But what if a CPU is hotunplugged, then the clockrate
for all the CPUs changes and then the gets re-hotplugged into the system.
Wouldn't in that case the udelay_val be used?

  Ralf
