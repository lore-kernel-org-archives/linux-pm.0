From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [RFC] QoS params patch
Date: Wed, 26 Sep 2007 16:41:59 -0700
Message-ID: <20070926164159.3b43479b.randy.dunlap__28186.0206545845$1190850266$gmane$org@oracle.com>
References: <20070926223712.GA22029@linux.intel.com>
	<20070926224026.GA23218@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070926224026.GA23218@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mgross@linux.intel.com
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Sep 2007 15:40:26 -0700 Mark Gross wrote:

> The following is the qos_param patch that implements a genralization of
> latency.c.
> 

Just some general comments (as on irc):

- use 'diffstat -p1 -w70' to summarize each patch
- use checkpatch.pl to check for coding style and other buglets
- has no API docs  :(




> +/* assumes qos_lock is held */
> +static void update_target(int i)

I'd prefer a better arg name than 'i'.

> +{

---
~Randy
Phaedrus says that Quality is about caring.
