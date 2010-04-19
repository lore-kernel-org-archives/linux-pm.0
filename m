From: Frans Pop <elendil@planet.nl>
Subject: Re: [regression] Sound not transferred to docking
	station after resume from StR
Date: Mon, 19 Apr 2010 16:58:39 +0200
Message-ID: <201004191658.40291.elendil__26026.8357852057$1271689339$gmane$org@planet.nl>
References: <201004162131.19171.elendil@planet.nl>
	<201004191439.45589.elendil@planet.nl>
	<s5hpr1vob79.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <s5hpr1vob79.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-pm@vger.kernel.org

On Monday 19 April 2010, Takashi Iwai wrote:
> Thanks for a quick check.  But I found that the patch isn't fully
> correct.
>
> The patch below should suffice instead of the previous one.
> Could you check it again?

Works as well.

Reported-and-tested-by: Frans Pop <elendil@planet.nl>
