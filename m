From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 13:17:45 +0100
Message-ID: <20100513121745.GA10749__38283.0312745229$1273753231$gmane$org@srcf.ucam.org>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@ericsson.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 12, 2010 at 09:35:30PM -0600, Paul Walmsley wrote:
> 
> Figuring out a different way to do this should not limit Android at all, 
> since Google can do what other Linux distributions do and continue to 
> patch opportunistic suspend/suspend-block calls into their kernels as 
> needed to ship devices, while contributing towards a different solution to 
> the problem.

I basically agree, except that despite having a year to do so none of us 
have come up with a different way that would actually work. Google have 
done this work. Who's going to prove that there is actually a different 
way to do this?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
