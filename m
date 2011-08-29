From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH pm-freezer 3/4] freezer: check freezing()
	before	leaving FROZEN state
Date: Mon, 29 Aug 2011 19:21:32 +0200
Message-ID: <20110829172132.GA12191__45800.5056986169$1314639468$gmane$org@redhat.com>
References: <20110829140418.GB18871@mtj.dyndns.org>
	<20110829140509.GC18871@mtj.dyndns.org>
	<20110829140549.GD18871@mtj.dyndns.org>
	<20110829163533.GB9973@redhat.com>
	<20110829171228.GA11339@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110829171228.GA11339@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Paul Menage <paul@paulmenage.org>, containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 08/29, Oleg Nesterov wrote:
>
> Hmm. But I got lost a bit. Why do we need freezer_lock to set/clear
> PF_FROZEN ? OK, the code below takes freezer_lock for freezing().
> Is there any other reason?

Ah, at least we need it to serialize with __thaw_task() which does
"if (frozen) wake_up()".

Oleg.
