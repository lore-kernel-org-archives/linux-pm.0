From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 20:22:08 +0100
Message-ID: <20100505192208.GB5085__524.273495148186$1273090421$gmane$org@srcf.ucam.org>
References: <20100505185225.GA4411@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005051511040.1885-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005051511040.1885-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 05, 2010 at 03:13:52PM -0400, Alan Stern wrote:

> Should the audio driver be smart enough to know that the codec needs to
> remain powered up during every opportunistic suspend?
> 
> Or only during opportunistic suspends while a call is in progress?  

The latter is obviously preferable...

> Does it know when a call is in progress?

Perhaps you could infer that from the audio routing setup? I don't know 
enough about embedded codecs.

> Does Android use forced suspends?

No.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
