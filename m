From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Function to tell S1 standby from STR
Date: Sat, 27 Aug 2011 00:45:41 +0200
Message-ID: <201108270045.41314.rjw@sisk.pl>
References: <CAFVyGY7NE4P4hZWSkzOhYbD-vX6b6oZT9y15LeZsQeh8S-u8iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFVyGY7NE4P4hZWSkzOhYbD-vX6b6oZT9y15LeZsQeh8S-u8iA@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maksim Rayskiy <maksim.rayskiy@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Saturday, August 27, 2011, Maksim Rayskiy wrote:
> Hi,
> 
> How can a driver in a suspend/resume call tell if the request is for
> STR or S1? On SoCs I am working with drivers need to take some extra
> steps to preserve context when STR is requested.
> 
> I had to add platform-dependent api to do that, but I figured I am not
> the only one having to deal with this. There are some comments in
> arch/arm/mach-at91/pm.c regarding having to treat S1 and S3
> differently because of wakeup source dependency on clock.
> 
> And unfortunately these differences has to be taken care of in the
> drivers, not platform code, because in some cases only device driver
> knows what represents the hardware context that needs to be saved.

Why not to save the same stuff for "S1" and "S3"?

Rafael
