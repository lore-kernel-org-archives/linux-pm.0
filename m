From: "Amit Kucheria" <kucheria.amit@gmail.com>
Subject: Re: Info on LDM, domain system and SOCs
Date: Tue, 18 Sep 2007 00:17:18 +0300
Message-ID: <52d486620709171417o106f876dsb13ab7e4f334be48@mail.gmail.com>
References: <46DEB51F.3010000@st.com>
	<1189430227.8343.5.camel@localhost.localdomain>
	<46E56E81.2050105@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46E56E81.2050105@st.com>
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
To: Francesco VIRLINZI <francesco.virlinzi@st.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 9/10/07, Francesco VIRLINZI <francesco.virlinzi@st.com> wrote:
> If you mean the <include/linux/clk.h>, I already saw it.
> I think it's good but it isn't enough.
> I want track also the devices on a clock to be able to notify (for each
> device) if a clock changes.

You should propose these changes to the clock framework. Designing a
new framework is unlikely to be accepted in the kernel easily since a
lot of platforms are using the clock framework already.

/Amit
--
Amit Kucheria, Linux developer
