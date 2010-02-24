From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: runtime PM: common hooks for static and runtime PM
Date: Wed, 24 Feb 2010 18:14:17 +0000
Message-ID: <20100224181417.GJ9018@sirena.org.uk>
References: <Pine.LNX.4.44L0.1002061110560.15298-100000@netrider.rowland.org>
	<Pine.LNX.4.44L0.1002080952150.1809-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1002080952150.1809-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 08, 2010 at 09:54:07AM -0500, Alan Stern wrote:
> On Sat, 6 Feb 2010, Alan Stern wrote:

> > I'll give it a try and we'll see how it turns out...

> And here it is.  You can see that the patch isn't ideal.

> Anyway, it should do what you want -- I haven't tested it.

It's taken a little while to test (and to be frank my testing is paper
thin) but it looks like this does what I'm looking for - thanks!
