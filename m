From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC] Runtime PM for host controllers
Date: Tue, 10 Apr 2012 10:25:46 +0100
Message-ID: <20120410092545.GC24465@sirena.org.uk>
References: <Pine.LNX.4.44L0.1204091007350.1429-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204091007350.1429-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 09, 2012 at 10:14:06AM -0400, Alan Stern wrote:
> On Sun, 8 Apr 2012, Kevin Cernekee wrote:

> > a) Is SATA/USB/MMC host controller suspension something that can be
> > accomplished within the existing runtime PM framework?

> Not only _can_ it be accomplished, it already _has_ been accomplished 
> (for USB at least, I'm not familiar with the others).

MMC does this quite happily too, controller and device suspends are
largely orthogonal.
