From: Frans Pop <elendil@planet.nl>
Subject: Re: [regression] Sound not transferred to docking
	station after resume from StR
Date: Mon, 19 Apr 2010 14:18:55 +0200
Message-ID: <201004191418.56592.elendil__40510.6516475373$1271679591$gmane$org@planet.nl>
References: <201004162131.19171.elendil@planet.nl>
	<201004191338.15750.elendil@planet.nl>
	<s5h8w8jps9j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <s5h8w8jps9j.wl%tiwai@suse.de>
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
> commit ea52bf260ecbb175339af3178c15788df21b7516
> Author: Daniel T Chen <crimsun@ubuntu.com>
> Date:   Sun Dec 27 18:48:29 2009 -0500
>
>     ALSA: hda: Add powerdown for Analog Devices HDA codecs
>
> Could you try to revert it?

Yep, that's the culprit.

Let me know if a fix needs to be tested.

Thanks,
FJP
