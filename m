From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: Any news regarding your suspend-next kernel patches?
Date: Wed, 17 Nov 2010 09:32:09 +1100
Message-ID: <4CE30669.7040104__31174.6144238443$1289946869$gmane$org@tuxonice.net>
References: <201011162320.44448.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011162320.44448.Martin@lichtvoll.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net
List-Id: linux-pm@vger.kernel.org

Hi Martin.

On 17/11/10 09:20, Martin Steigerwald wrote:
> Resent due to typo in address of linux-pm mailing list.
>
> Hi Nigel!
>
> Any news regarding your suspend-next kernel patches?
>
> I am running 2.6.36 with in kernel suspend to disk on my ThinkPad T42, my
> T23 and my Dell Workstation at work quite successfully. Thus I can say its
> stable and I have a good testing base for any updated patches you come up
> with.
>
> I didn't yet test in kernel suspend of 2.6.37 which AFAIK sports LZO
> compression yet.

Thanks for the interest.

I asked Rafael not to merge them yet, because I saw some issues with the 
readahead patch when the image gets large. The extra memory used for 
readahead (though only 1000 pages max) caused resume failures once for 
me. I therefore want to investigate more carefully exactly how memory is 
used at resume time, and perhaps prepend a patch or two that address 
that issue (presumably there's some sort of bug or potential for 
improvement there).

Unfortunately I'm not moving very fast on it, because I'm getting to the 
pointy end of a course I'm doing, and have to get assessment done for that.

Regards,

Nigel
