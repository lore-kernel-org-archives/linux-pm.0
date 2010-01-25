From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] PM / i915: Skip kernel VT switch during
 suspend/resume if KMS is used
Date: Mon, 25 Jan 2010 21:27:20 +0000
Message-ID: <20100125212720.7d3af280__1996.17755502022$1264454863$gmane$org@lxorguk.ukuu.org.uk>
References: <201001240055.59479.rjw@sisk.pl>
	<20100125184350.0fbad233@lxorguk.ukuu.org.uk>
	<20100125104938.6b34d61c@jbarnes-piketon>
	<201001252217.39778.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001252217.39778.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: airlied@linux.ie, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

> > But in that case we should be able to disable the VT switch disable
> > path; we just have to check each driver as it's loaded.
> 
> OK, what the right sequence of checks would be in that case and where to place
> them?

Why are we even driving a vt switch direct from the suspend/resume
logic ? The problem starts there. If it was being handled off the device
suspend/resume method then there wouldn't be a mess to start with ?

Start at the beginning

- Why do we switch to arbitarily chosen 'last vt'
- Why isn't vt related suspend/resume handled by the device

Alan
