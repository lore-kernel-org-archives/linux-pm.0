From: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@bitplanet.net>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Wed, 6 Jun 2007 16:14:52 -0400
Message-ID: <59ad55d30706061314s45c86e7eja587244a6ed37812@mail.gmail.com>
References: <200705181207.45868.marcus@better.se>
	<tkrat.5b4ba1068f8b64ee@s5r6.in-berlin.de>
	<tkrat.07833adfb2306655@s5r6.in-berlin.de>
	<200705311441.14021.marcus@better.se>
	<465EDA0E.8060400@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <465EDA0E.8060400@s5r6.in-berlin.de>
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
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Marcus Better <marcus@better.se>
List-Id: linux-pm@vger.kernel.org

On 5/31/07, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Marcus, thanks for the fast feedback.

I've posted an updated version of the patch here that fixes a
byteswapping problem, and should make the stack actually work after
resuming:

http://marc.info/?l=linux1394-devel&m=118108604226326&w=2

cheers,
Kristian
