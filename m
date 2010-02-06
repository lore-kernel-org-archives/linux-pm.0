From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: runtime PM: common hooks for static and runtime PM
Date: Sat, 6 Feb 2010 15:46:33 +0000
Message-ID: <20100206154632.GA3664@sirena.org.uk>
References: <20100205224421.GA5466@sirena.org.uk>
	<Pine.LNX.4.44L0.1002052148340.6076-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1002052148340.6076-100000@netrider.rowland.org>
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

On Fri, Feb 05, 2010 at 09:57:46PM -0500, Alan Stern wrote:
> On Fri, 5 Feb 2010, Mark Brown wrote:

> > It's not that it's hard per se, it's that it feels like it's peering
> > inside the implementation of the API.  Having the PM core provide

> You mean like providing an is_runtime_suspended() test?  Then you could 
> write:

> 	int my_suspend(struct device *dev)
> 	{
> 		if (is_runtime_suspended(dev))
> 			return 0;
> 		return my_runtime_suspend(dev);
> 	}

> Or maybe you'd prefer to see a convenient pm_use_runtime_suspend() 
> function that you could use for your dev_pm_ops.suspend pointer, which 
> would do essentially the same as the above?  (Along with a 
> corresponding pm_use_runtime_resume() function, of course.)

Either (or both, of course - implementing the second would probably
imply the former).  The ops that can be assigned would be the clearest
option but the accessor function should be enough to make it clear that
this is something drivers are supposed to be doing.
