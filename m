From: Mark Gross <mgross@linux.intel.com>
Subject: Re: [RFC] QoS params patch
Date: Fri, 28 Sep 2007 10:22:01 -0700
Message-ID: <20070928172201.GB3219__22703.5865806558$1191000228$gmane$org@linux.intel.com>
References: <20070926223712.GA22029@linux.intel.com>
	<20070926224026.GA23218@linux.intel.com>
	<20070927232501.79f9f4bd.akpm@linux-foundation.org>
	<20070928064113.GA32532@linux-sh.org>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070928064113.GA32532@linux-sh.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 28, 2007 at 03:41:13PM +0900, Paul Mundt wrote:
> On Thu, Sep 27, 2007 at 11:25:01PM -0700, Andrew Morton wrote:
> > On Wed, 26 Sep 2007 15:40:26 -0700 Mark Gross <mgross@linux.intel.com> wrote:
> > > +int qos_add_requirement(int qos, char *name, s32 value);
> > > +int qos_update_requirement(int qos, char *name, s32 new_value);
> > > +void qos_remove_requirement(int qos, char *name);
> > 
> > It's a bit rude stealing the entire "qos" namespace like this - there are
> > many different forms of QoS, some already in-kernel.
> > 
> > s/qos/pm_qos/g ?
> 
> lat_qos or something might be more suitable.. it's a latency property, not
> a power management one (even if pm ends up being the primary user of it).

Its not just latency otherwise I'd agree with you.  right now I'm
thinking of changing things to "qospm" unless there folks feel strongly
about pm_qos.

--mgross
