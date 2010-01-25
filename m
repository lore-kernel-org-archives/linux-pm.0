From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / i915: Skip kernel VT switch during
	suspend/resume if KMS is used
Date: Mon, 25 Jan 2010 22:54:37 +0100
Message-ID: <201001252254.37635.rjw__33585.3025237613$1264456598$gmane$org@sisk.pl>
References: <201001240055.59479.rjw@sisk.pl> <201001252217.39778.rjw@sisk.pl>
	<20100125212720.7d3af280@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100125212720.7d3af280@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: airlied@linux.ie, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Monday 25 January 2010, Alan Cox wrote:
> > > But in that case we should be able to disable the VT switch disable
> > > path; we just have to check each driver as it's loaded.
> > 
> > OK, what the right sequence of checks would be in that case and where to place
> > them?
> 
> Why are we even driving a vt switch direct from the suspend/resume
> logic ? The problem starts there. If it was being handled off the device
> suspend/resume method then there wouldn't be a mess to start with ?
> 
> Start at the beginning
> 
> - Why do we switch to arbitarily chosen 'last vt'
> - Why isn't vt related suspend/resume handled by the device

Well, that was added long ago as a workaround for some problems people
reported (presumably).  I've never looked at that before, so I can't really
tell why someone did it this particular way.

Obviously I'd like to clean it up, though.

So, what device should handle this in your opinion?

Rafael
