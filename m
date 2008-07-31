From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: suspend to  ram regression in current GIT, bisected
Date: Thu, 31 Jul 2008 12:07:49 -0700
Message-ID: <200807311207.49335.jbarnes__25253.6529129886$1217531473$gmane$org@virtuousgeek.org>
References: <48920CF7.4060907@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48920CF7.4060907@gmx.de>
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
To: Dieter Ries <clip2@gmx.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, pavel@suse.cz, willy@linux.intel.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, July 31, 2008 12:05 pm Dieter Ries wrote:
> Hi,
>
> starting from 2.6.27-rc1, my Laptop (Thinkpad T60) did not return from
> suspend to ram anymore.
>
> When it should resume, the sleep LED went off, power went on, HD LED
> flashed once, but the display stayed black.

Can you test the fix in http://bugzilla.kernel.org/show_bug.cgi?id=11178?  
Hopefully it's a DUP.

Thanks,
Jesse
