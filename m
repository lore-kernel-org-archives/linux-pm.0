From: Matthias-Christian Ott <ott@mirix.org>
Subject: Re: iwlagn on Thinkpad X200
Date: Mon, 15 Feb 2010 15:31:38 +0100
Message-ID: <20100215143137.GA4789@qi>
References: <20100215134823.GA2864@qi>
 <4B79538F.4090501@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4B79538F.4090501@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@mit.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 15, 2010 at 09:00:47AM -0500, Andy Lutomirski wrote:
> Looks mostly reasonable to me.  Did you try 'iwconfig wlan0 power on'?

Yes, it didn't make an improvement.
 
> If you're feeling adventurous, try iwlcore.no_sleep_autoadjust=0 and
> 'iwconfig wlan0 power on'.  The combination works for me and
> decreases power consumption a lot at the cost of a little bit of
> latency.

It worked for me too, even if it just saved about 6 wake-ups per
second.

But I still wonder where the other parameters most users report about
have gone.

> --Andy

Regards,
Matthias-Christian
