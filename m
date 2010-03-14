From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM_QOS updates for 2.6.34-rc1
Date: Sun, 14 Mar 2010 07:26:37 +0100
Message-ID: <20100314062637.GA12064__15439.2847013243$1268548077$gmane$org@elf.ucw.cz>
References: <20100314003425.GA17812@mgross-acer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100314003425.GA17812@mgross-acer>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: 640E9920 <640e9920@gmail.com>
Cc: dwalker@codeaurora.org, tiwai@suse.de, bruce.w.allan@intel.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat 2010-03-13 16:34:25, 640E9920 wrote:
> The following patch series implements to following:
> 1) pm_qos now uses a handle based implementation.  No more string
> compares while walking lists.
> 2) renames the exports to using more accurate names.
> 3) updates kernel clients of pm_qos per this change
> 4) added ascii interface to pmqos recognizing strings formatted in 10
> charactor format "0x12345678"
> 5) added new pm_qos class, "system_bus_throughput"
> 
> I would like to see this series make it into 2.6.34 if its not too late. 

I believe it is... -rc1 is past us.

Also... the way the patches are structured... that will break bisect,
no?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
