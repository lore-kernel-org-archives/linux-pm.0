From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 15:58:18 +0100
Message-ID: <20070704145818.GA7784__41120.4629847363$1183561578$gmane$org@srcf.ucam.org>
References: <20070703224215.GA30081@srcf.ucam.org>
	<Pine.LNX.4.44L0.0707041030540.25704-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0707041030540.25704-100000@netrider.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 04, 2007 at 10:38:47AM -0400, Alan Stern wrote:

> Okay, I agree that (1) can be handled without too much effort.  But 
> doing it adds an extra test to _every_ driver's I/O pathway.  Freezing 
> userspace does not incur all this additional overhead.

For runtime PM to work it's already necessary to have a test in that 
path to check if the device is suspended. I can't see how this adds any 
overhead to the common case.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
