From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC 07/15] PM / Hibernate: add sws_modules_ops
Date: Wed, 24 Mar 2010 22:31:09 +0100
Message-ID: <4BAA849D.1080308__23299.7365099893$1269473414$gmane$org@gmail.com>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-7-git-send-email-jslaby@suse.cz>
	<20100324203634.GH5798@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100324203634.GH5798@elf.ucw.cz>
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

On 03/24/2010 09:36 PM, Pavel Machek wrote:
> On Tue 2010-03-23 17:17:35, Jiri Slaby wrote:
>> +struct sws_module_ops {
...
> sws_ prefix is strange.

Yeah, noted on this in the previous mail.

> Plus, could we get some docs what it does? Stuff like "get_writer" is
> not entirely self-documenting.

Ah, this I wanted to do. Thanks for the reminder.

-- 
js
