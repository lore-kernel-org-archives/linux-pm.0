From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC 06/15] PM / Hibernate: swap,
	remove swap_map_handle usages
Date: Wed, 24 Mar 2010 22:29:14 +0100
Message-ID: <4BAA842A.6060906__14066.3240374581$1269473416$gmane$org@gmail.com>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-6-git-send-email-jslaby@suse.cz>
	<20100324203329.GG5798@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100324203329.GG5798@elf.ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/24/2010 09:33 PM, Pavel Machek wrote:
> On Tue 2010-03-23 17:17:34, Jiri Slaby wrote:
>> Some code, which will be moved out of swap.c, needs know nothing about
>> swap. There will be also other than swap writers later, so that it
>> won't make sense at all.
>>
>> Make it a global static in swap.c as a singleton.
> 
> I guess I just dislike global static. Logically, methods do operate on
> handles, so...

Ok, "upper layers" may get a handle via .get_reader/writer. The downside
is that they would have to get (void *) and pass (void *) down again. I
wanted to avoid that (taking into account that it's a singleton).

> I don't see a point and I do not think the change is an improvement.

The point was to avoid (void *)'s and save users from transferring
pointer as a handle. No matter what, the decision is not up to me,
discussion indeed welcome.

-- 
js
