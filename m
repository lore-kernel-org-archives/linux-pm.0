From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: Re: [RFC/PATCH 2/2] kernel: don't update load average
	during snapshot/shutdown
Date: Fri, 27 Apr 2007 17:55:47 +0300
Message-ID: <84144f020704270755w427f1c16jba7e18914fcc0418@mail.gmail.com>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
	<20070427145212.GO22250@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070427145212.GO22250@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On 4/27/07, Pavel Machek <pavel@ucw.cz> wrote:
> Is it kernel problem? We _had_ high load, and load average goes down
> pretty quickly.

I think it is. The load average is no longer true when we resume.

On 4/27/07, Pavel Machek <pavel@ucw.cz> wrote:
> NAK. This slows down regular operation, at it is 30 lines for what
> should have been one (or five).
>
> Just place avenrun[0] = avenrun[1] = avenrun[2] = 0 at strategic place
> if you feel strongly about this. Additional points for using Rafael's
> "suspend done" notifier so that you don't have to modify suspend core.

Will do. Thanks Pavel.
