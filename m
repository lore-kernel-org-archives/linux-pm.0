From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Improving High-Load Performance with the Ondemand
 Governor [PATCH ATTACHED]
Date: Fri, 17 Sep 2010 06:46:00 -0700
Message-ID: <20100917064600.5d478658__47870.4158253551$1284731157$gmane$org@infradead.org>
References: <4C88EF04.1030908@verisign.com> <4C928094.7080207@verisign.com>
	<201009171125.44403.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009171125.44403.trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, David C Niemi <dniemi@verisign.com>, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Sep 2010 11:25:44 +0200
Thomas Renninger <trenn@suse.de> wrote:

> On the Opteron or Xeon system? That would mean that reducing frequency
> from OS still is an important power consumption knob even on latest
> Westmere systems.

it is for staying out of the turbo range. the turbo range is not power
efficient (but good for performance)

below turbo, the actual impact is a LOT less....

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
