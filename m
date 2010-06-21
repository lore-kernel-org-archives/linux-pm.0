From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [PATCH 1/9] PM / Hibernate: swap,
	switch to hibernate_io_handle
Date: Tue, 22 Jun 2010 07:58:51 +1000
Message-ID: <4C1FE09B.9040703__12810.2527153262$1277157621$gmane$org@crca.org.au>
References: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
	<4C1205DC.1080200@crca.org.au> <4C1F8366.70306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C1F8366.70306@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Jiri.

On 22/06/10 01:21, Jiri Slaby wrote:
> On 06/11/2010 11:46 AM, Nigel Cunningham wrote:
>> On 02/06/10 18:52, Jiri Slaby wrote:
>>> I addressed the comments I got on the previous RFC. I left the handles
>>> in place, the functions in hibernate_io_ops now works on them. Further
>>> I got rid of the memory barriers and minimized global variables as much
>>> as possible. Comments welcome.
>>
>> I would like to hear the arguments for using these handles. I understand
>> there may have been some previous discussion, but am unable to find it.
>>
>> It seems far more sensible to me to not pass around a handle that
>> virtually nothing actually uses, and instead store and utilise the state
>> in the place where it is actually useful. If we had more than one struct
>> hibernate_io_handle in use at a time, I could understand going this way.
>> As it stands, however...
>
> Hi, it I added that based on this: http://lkml.org/lkml/2010/3/24/458

Okay; thanks.

Looking at Pavel's comment is confusing. The variable you were adding 
isn't "global static" (that's a contradiction in terms anyway). Its 
scope is the file level.

Since the data is only used in this file, your change makes perfect 
sense to me.

Rafael, Pavel: care to discuss this further?

Nigel
