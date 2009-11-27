From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Runtime resume of children
Date: Fri, 27 Nov 2009 13:20:51 +0000
Message-ID: <20091127132050.GC29512@sirena.org.uk>
References: <Pine.LNX.4.44L0.0911251542030.2879-100000@iolanthe.rowland.org>
	<200911261747.09019.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911261747.09019.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 26, 2009 at 05:47:08PM +0100, Oliver Neukum wrote:
> Am Mittwoch, 25. November 2009 21:46:14 schrieb Alan Stern:

> > That's not a good example because there's nothing wrong with suspending
> > some of the devices while leaving the clock and the others running.
> > You'll have to search harder to find a group of devices which really do
> > need to be suspended all together.

> True, so think about a shared switchable power line. But that's the
> way of the future.

There's already quite a few examples of that.  For supply lines handled
via the regulator API the API implements reference counting so that the 
devices don't need to worry about other users - it just drops the refs
to the supply.  For shared power gating blocks in CPUs (like SH, OMAP
and S3C64xx have for example) the current idea is that the bus will do a
similar thing.
