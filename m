From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 12 May 2010 12:22:28 +0100
Message-ID: <20100512112227.GA4312__44704.2406340644$1273663424$gmane$org@sirena.org.uk>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<87632vhbs8.fsf@deeprootsystems.com>
	<AANLkTikJV-wQX9xh8mRVptebJBctcRrQaUls-IGDhQar@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikJV-wQX9xh8mRVptebJBctcRrQaUls-IGDhQar@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: Geoff Smith <geoffx.smith@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 11, 2010 at 06:11:09PM -0700, Arve Hj?nnev?g wrote:

> > 2.2 Usage in PM aware drivers
> > ==============================

> > [An example of how a driver already using runtime PM would use
> > ?a suspend blocker would also be helpful.

> An audio driver can block suspend while audio is playing. We don't
> currently use the runtime pm framework since this is new, but we do
> runtime pm by turning off clocks and power when the device is
> inactive.

Could you clarify what's going on here please?  What do you mean by an
"audio driver" here - there's several different classes of driver which
work together to produce the embedded audio subsystem and I'm not clear
which you're referring to here.  I'd not expect a chip-specific audio
driver to be taking suspend blockers at all except during things like
accessory detect handling which can take a long time.  A system-specific
driver could reasonably block during playback but doing it in a chip
specific driver sounds like a bit too much of a policy decision.

The kernel runtime PM framwwork tends not to come into play for anything
except MFD and SoC drivers with audio where they're a component of PM on
the larger chip and it's useful for coordinating with the other drivers
in play.  Otherwise we already have very detailed automatic power
management (especially for the CODECs) and there's no benefit in
bouncing through runtime PM.
