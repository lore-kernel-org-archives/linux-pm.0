From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: parallel suspend/resume
Date: Sat, 08 Dec 2007 11:08:41 +0000
Message-ID: <475A7B39.7030106@superbug.co.uk>
References: <Pine.LNX.4.44L0.0712071120400.4209-100000@iolanthe.rowland.org>	<20071207180112.8C68B1E3692@adsl-69-226-248-13.dsl.pltn13.pacbell.net>	<200712080900.45623.oliver@neukum.org>
	<20071208102143.GA7195@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071208102143.GA7195@elf.ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> On Sat 2007-12-08 09:00:44, Oliver Neukum wrote:
>   
>> Am Freitag, 7. Dezember 2007 19:01:12 schrieb David Brownell:
>>     
>>> FWIW the appended patch removes that rude "order of registration"
>>> policy, so that the suspend/resume list matches the device tree.
>>> It's behaved OK on PCs and, in light duty, a few development boards;
>>> I've carried it around most of this year.
>>>       
>> As it is a tree, why not store it as such?
>>     
>
> IIRC because we do not want recursive tree walkers in the kernel --
> stack limits.
>
>   

Surely it is possible to code a tree walker that is not a recursive 
function?
I believe you can use a simple loop and the heap to store state that 
would otherwise be stored on the stack in a recursive function.
