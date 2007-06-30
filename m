From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.22-rcX Transmeta/APM regression
Date: Sat, 30 Jun 2007 00:06:36 -0400
Message-ID: <4685D6CC.9070007@zytor.com>
References: <20070630030343.31711.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070630030343.31711.qmail@science.horizon.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux@horizon.com
Cc: bk@suse.de, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, michal.k.k.piotrowski@gmail.com, ak@suse.de
List-Id: linux-pm@vger.kernel.org

linux@horizon.com wrote:
> 
> Anyway, the patch which introduces the problem is the aptly named 3ebad:
> 3ebad59056: [PATCH] x86: Save and restore the fixed-range MTRRs of the BSP when suspending
> 
> 2.6.22-rc6 plus that one commit reverted successfully does APM suspend
> (and resume) for me.

Okay, I would guess that that patch probably touches MTRRs without 
actually verify that the CPU *has* MTRRs -- the Transmeta Crusoe CPU 
doesn't have MTRRs.

	-hpa
