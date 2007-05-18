From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Fri, 18 May 2007 08:28:21 -0700
Message-ID: <20070518082821.230dd4c5.akpm@linux-foundation.org>
References: <200705181207.45868.marcus@better.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705181207.45868.marcus@better.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcus Better <marcus@better.se>
Cc: Kristian =?ISO-8859-1?B?SPhnc2Jlcmc=?= <krh@redhat.com>, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Fri, 18 May 2007 12:07:40 +0200 Marcus Better <marcus@better.se> wrote:

> Hi,
> 
> the fw-ohci driver breaks suspend to RAM on my Thinkpad R60, Intel Core 2 Duo, 
> kernel 2.6.22-rc1 (x86_64, SMP). It does suspend but hangs on resume if the 
> fw-ohci module is loaded. (See also the original report [1]).
> 
> Best regards,
> 
> Marcus
> 
> [1] http://permalink.gmane.org/gmane.linux.power-management.general/5819
> 

(added linux1394-devel to cc)
